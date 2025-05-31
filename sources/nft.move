module functionexample::suiGhana_nft {
    use sui::url::{Self, Url};
    use std::string;
    use sui::event;
    use sui::package;
    use sui::display;

    /// SUIGHANA_NFT is a struct that represents a unique SUIGHANA NFT.
    public struct SUIGHANA_NFT has drop {}

    /// SuiGhana_nft is a struct that represents an NFT object in the Sui blockchain.
    public struct SuiGhana_nft has key, store {
        /// The unique identifier of the NFT.
        id: object::UID,
        /// The name of the NFT.
        name: string::String, 
        /// A short description of the NFT.
        description: string::String,
       // /// The URL of the NFT.
       // url: Url,
        /// The URL of the image associated with the NFT.
        image_url: Url,
    }

    /// Mintnft_event is a struct that represents an event emitted when an NFT is minted.
    public struct Mintnft_event has copy, drop {
        /// The unique identifier of the object.
        object_id: object::ID,
        /// The address of the creator of the NFT.
        creator: address,
        /// The name of the NFT.
        name: string::String,
    }

     /// Initializes the SUIGHANA NFT.
     ///
     /// This function initializes the SUIGHANA NFT by creating a new package and publishing it to the sender.
     /// It also creates a new display object and publishes it to the sender.
     ///
     /// Args:
     /// * `witness`: A SUIGHANA NFT.
     /// * `ctx`: The transaction context.
     fun init(witness: SUIGHANA_NFT, ctx: &mut TxContext) {
        let publisher = package::claim(witness, ctx);

        let keys = vector[
            string::utf8(b"name"),
            string::utf8(b"description"),
          //  string::utf8(b"url"),
            string::utf8(b"image_url"),
            string::utf8(b"creator")
        ];

        let values = vector[
            string::utf8(b"{name}"),
            string::utf8(b"{description}"),
           // string::utf8(b"{url}"),
            string::utf8(b"{image_url}"),
            string::utf8(b"SuiGhana")
        ];

        let mut display = display::new_with_fields<SuiGhana_nft>(
            &publisher, 
            keys,
            values,
            ctx
        );

        display::update_version(&mut display);

        transfer::public_transfer(publisher, tx_context::sender(ctx));
        transfer::public_transfer(display, tx_context::sender(ctx));
    }

    /// Mints a new NFT object.
    ///
    /// This function mints a new NFT object and transfers it to the sender.
    ///
    /// Args:
    /// * `name`: The name of the NFT.
    /// * `description`: A short description of the NFT.
    /// * `url`: The URL of the image associated with the NFT.
    /// * `ctx`: The transaction context.
    public entry fun mint(
        name: vector<u8>,
        description: vector<u8>,
       // url: vector<u8>,
        image_url: vector<u8>,
        ctx: &mut tx_context::TxContext,
    ) {
        let nft = SuiGhana_nft {
            id: object::new(ctx),
            name: string::utf8(name),
            description: string::utf8(description),
          //  url: url::new_unsafe_from_bytes(url),
            image_url: url::new_unsafe_from_bytes(image_url),
        };

        let sender = tx_context::sender(ctx);

        event::emit(Mintnft_event {
            object_id: object::uid_to_inner(&nft.id),
            creator: sender,
            name: nft.name,
        });

        transfer::public_transfer(nft, sender);
    }

    /// Updates the description of an NFT object.
    ///
    /// Args:
    /// * `nft`: The NFT object to be updated.
    /// * `new_description`: The new description of the NFT.
    public entry fun update_description(
        nft: &mut SuiGhana_nft,
        new_description: vector<u8>,
    ) {
        nft.description = string::utf8(new_description);
    }

    /// Burns an NFT object.
    ///
    /// Args:
    /// * `nft`: The NFT object to be burned.
    public entry fun burn(nft: SuiGhana_nft) {
        let SuiGhana_nft { id, name: _, description: _,  image_url: _ } = nft;
        object::delete(id);
    }
}
