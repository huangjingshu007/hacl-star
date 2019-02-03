module Hacl.Poly1305_256

open Lib.IntTypes
open Lib.Buffer

open Hacl.Impl.Poly1305.Fields

let blocklen = 16ul

type poly1305_pre = lbuffer (Lib.IntVector.vec_t U64 4) 20ul
type poly1305_acc = lbuffer (Lib.IntVector.vec_t U64 4) 5ul

let poly1305_init (pre:poly1305_pre) (acc:poly1305_acc) (key:lbuffer uint32 32ul) =
  Hacl.Impl.Poly1305.poly1305_init #M256 key pre acc

let poly1305_update_blocks (pre:poly1305_pre) (acc:poly1305_acc) (len:size_t{v len % v blocklen == 0}) (text:lbuffer uint8 len) =
  Hacl.Impl.Poly1305.poly1305_update #M256 len text pre acc

let poly1305_update_padded (pre:poly1305_pre) (acc:poly1305_acc) (len:size_t) (text:lbuffer uint8 len) =
  Hacl.Impl.Poly1305.poly1305_update #M256 len text pre acc

let poly1305_update_last (pre:poly1305_pre) (acc:poly1305_acc) (len:size_t{v len < 16}) (text:lbuffer uint8 len) =
  Hacl.Impl.Poly1305.poly1305_update #M256 len text pre acc

let poly1305_finish (tag:lbuffer uint8 16ul) (k:lbuffer uint8 32ul) (acc:poly1305_acc) =
  Hacl.Impl.Poly1305.poly1305_finish #M256 k acc tag

let poly1305_mac (o:lbuffer uint8 16ul) (t:buffer uint8) (l:size_t{length t == v l}) (k:lbuffer uint8 32ul) =
  Hacl.Impl.Poly1305.poly1305_mac #M256 o l t k