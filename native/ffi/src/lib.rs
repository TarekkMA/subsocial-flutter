mod handler;
mod pb;
mod shared_buffer;

use allo_isolate::Isolate;
use async_std::task;
use once_cell::sync::OnceCell;
use sdk::runtime::SubsocialRuntime;
use sdk::subxt;

use pb::subsoical;
use prost::Message;
use shared_buffer::SharedBuffer;

static CLIENT: OnceCell<subxt::Client<SubsocialRuntime>> = OnceCell::new();

#[no_mangle]
pub extern "C" fn subsoical_init_client(port: i64) -> i32 {
    let isolate = Isolate::new(port);
    let task = isolate.catch_unwind(async move {
        subxt::ClientBuilder::new()
            .set_url("wss://rpc.subsocial.network")
            .build()
            .await
            .map(|client| {
                CLIENT
                    .set(client)
                    .map_err(|_| ())
                    .expect("client already set");
            })
    });
    task::spawn(task);
    1
}

#[no_mangle]
pub extern "C" fn subsocial_dispatch(port: i64, ptr: Box<SharedBuffer>) -> i32 {
    let isolate = Isolate::new(port);
    let req: subsoical::Request = match prost::Message::decode(ptr.as_slice()) {
        Ok(v) => v,
        Err(e) => {
            let mut bytes = Vec::new();
            let kind = subsoical::error::Kind::InvalidProto.into();
            subsoical::Error {
                kind,
                msg: e.to_string(),
            }
            .encode(&mut bytes)
            .expect("should never fails");
            isolate.post(bytes);
            return 0xbadc0de;
        },
    };
    let client = match CLIENT.get() {
        Some(v) => v,
        None => return 0xdead,
    };
    let task = isolate.catch_unwind(handler::handle(client, req));
    task::spawn(task);
    1
}

/// a no-op function that forces xcode to link to our lib.
/// ## Safety
/// lol
#[inline(never)]
#[no_mangle]
pub unsafe extern "C" fn subsocial_link_me_plz() {}
