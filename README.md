### Demo 4: [Shop App](https://github.com/jinyongnan810/flutter-shop-app)
#### Basic Functions
- Product List with [GridView](https://github.com/jinyongnan810/flutter-shop-app/commit/d38f4ae47765286ee198b1ae5fce21c5fa6e7f1c)
![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630020879/czcouyevx48lh27ujmi8.png)
- [Basic way](https://github.com/jinyongnan810/flutter-shop-app/commit/0d9632149c38e7ef8b6566d8bc2dab70ef7fdd62) and [Using router](https://github.com/jinyongnan810/flutter-shop-app/commit/b246e726468192362b1728d1b1b8f88289f3b3c4) to pop up a new screen
- Using Provider to create&get products state
- Difference with [mixin and inhreritance](https://github.com/jinyongnan810/flutter-shop-app/commit/05c2c20a34e9ca54049562f9bb0cc8147bc2cda8)
- [Product Detail Page](https://github.com/jinyongnan810/flutter-shop-app/commit/fa1b21a715be4974f1df97e47fed92748efaa5f0)
![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630021288/nqh9awxtdxzabdozfkad.png)
- [Nested provider](https://github.com/jinyongnan810/flutter-shop-app/commit/8e61df8455b46c18be6b23a97ff3eb17ef256774) & Using [ChangeNotifierProvider.value](https://github.com/jinyongnan810/flutter-shop-app/commit/83cfe06ab569c972c983ee242d6a330c1b3b499c)
- Use [Consumer](https://github.com/jinyongnan810/flutter-shop-app/commit/2b5ffec39e4e9e8d9ba4d797a7f5b73c6908636a) to partially listen for states, also in [here](https://github.com/jinyongnan810/flutter-shop-app/commit/a6301da835d7b47d0e88ca04acf7138cc83f53d3)
- Use [Local State](https://github.com/jinyongnan810/flutter-shop-app/commit/b6e3fb38eb1cd2821be3a70c47f41957bee104dd) instead of Provider State
- [Cart State and multiple Providers, also Cart icon](https://github.com/jinyongnan810/flutter-shop-app/commit/f87a3761e436ea0190f364ccd6522404b9e1a3e6)
![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630021774/fhlvnfc9ttdjakshxzci.png)
- [Cart Screen](https://github.com/jinyongnan810/flutter-shop-app/commit/e1b2975bb1000ce09c65ae2dfdbe14f204bafedd) (Use Expand when using ListView inside Column)
![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630021945/tolukdsymxcxvjfqsebv.png)
- [Order Screen](https://github.com/jinyongnan810/flutter-shop-app/commit/918d3d8b8f3a0ba197f7d544cc889d63bf809175) and [expand order detail](https://github.com/jinyongnan810/flutter-shop-app/commit/8526aad8181e6a68c61ba4fe0afb3e0ae9053fee)
![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630022087/kxuojeoyop5j5iecf1sj.png)
- [Add Drawer](https://github.com/jinyongnan810/flutter-shop-app/commit/929682027ad08bd76a97930aea0361690adf1477)
![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630022154/piyzhyptlo20jhjqn53w.png)

#### User Interactions
- [SnackBar](https://github.com/jinyongnan810/flutter-shop-app/commit/22164ddd1bdb6fae00c2dfa46c57aa2401f6dc5c)
![snackbar](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630970345/jxaijrjvceyytbitmmie.png)
- [Dialog](https://github.com/jinyongnan810/flutter-shop-app/commit/f34f47c8a3a0406c652fbecf051762c08d4ce2bf)
![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630970457/cj9bg5plvz3jeqzztf88.png)
- [User Product List](https://github.com/jinyongnan810/flutter-shop-app/commit/cd96757d0eb4bf5e74b1cc4c6b397b0819b614ce)
![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630970549/hbt9qjw984y2fhfxm7vh.png)
- Edit User Product [Form](https://github.com/jinyongnan810/flutter-shop-app/commit/bf6327de888c6fd057c10744925699a299e8de4b), [Focus form input](https://github.com/jinyongnan810/flutter-shop-app/commit/bfbf69cc356fcf5a4435f56e2d1f50781add7c96), [Multiline Inputs](https://github.com/jinyongnan810/flutter-shop-app/commit/3b925d559a85c2d166cc7f042b5336a446c5765f), [Image Url and Preview](https://github.com/jinyongnan810/flutter-shop-app/commit/c7466e7b55735a7b00a9167f6b41eb89e5b32133) , [Validate](https://github.com/jinyongnan810/flutter-shop-app/commit/9f3fbd1673cf4ab3487b99f436fbb0d5712dc1bf) & [Submit](https://github.com/jinyongnan810/flutter-shop-app/commit/c3824d4945b2d50c737d2ed98803718213d73c1b) form. Finally [Editing product](https://github.com/jinyongnan810/flutter-shop-app/commit/42f7a90673215bb2a4de38149b512c2b85a99232).
![image](https://res.cloudinary.com/dsiz9ikkt/image/upload/v1630970970/lurcxlhwwrjekjuxrdbq.png)
- Use [dispose method](https://github.com/jinyongnan810/flutter-shop-app/commit/168f63191834d58e3dced4dc1d6d9735527a8257) when there are FocusNode or EditTextController

#### Communicate with servers
- Encode products into json and [save to server](https://github.com/jinyongnan810/flutter-shop-app/commit/27a4c0853261c9a32411a79584698b12657202f0)(rtdb) 
- [Show spinner](https://github.com/jinyongnan810/flutter-shop-app/commit/7f83eb2d38e86f17f79c12e4310389efecae55f9) during server requests
- [Catch errors](https://github.com/jinyongnan810/flutter-shop-app/commit/dcced1c2a2761fea1f5f40c3c8f2d3d356608f24) and display notice
- [Decode products](https://github.com/jinyongnan810/flutter-shop-app/commit/dc5e5217f008df32888f5c6f89aaf33b454a0b8e) json into object
- [Pull down to refresh](https://github.com/jinyongnan810/flutter-shop-app/commit/4949bac593f543f01ac5426313c3275bb9fb6d41)
- [Optimistic Update](https://github.com/jinyongnan810/flutter-shop-app/commit/743e9a5c6034504c29fb14d60bc18de30e37827f)
- [Encode](https://github.com/jinyongnan810/flutter-shop-app/commit/2b3b02390c078c64c99fed474c3b1140da3b45b3) and [Decode](https://github.com/jinyongnan810/flutter-shop-app/commit/c4239845beb456f46de99aabd8016a505071d6e2) nested object
- [Handle null value](https://github.com/jinyongnan810/flutter-shop-app/commit/24ab3b2507af94302d0076bcea120534d7c3365b)
- [Partial stateful](https://github.com/jinyongnan810/flutter-shop-app/commit/f4fa10d74b0f3f43a419555e7e6c5c18ff0dcf0c) to prevent total re-render
- Using [FutureBuilder](https://github.com/jinyongnan810/flutter-shop-app/commit/f4fa10d74b0f3f43a419555e7e6c5c18ff0dcf0c) and [improvement](https://github.com/jinyongnan810/flutter-shop-app/commit/52386a3f5591ad9c0579d4010c9b920df42a1cde)