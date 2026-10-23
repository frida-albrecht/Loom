module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-118> : tensor<8x4x9x9xi16>}> : () -> tensor<8x4x9x9xi16>
    %1 = tosa.reverse %0 {axis = 1 : i32} : (tensor<8x4x9x9xi16>) -> tensor<8x4x9x9xi16>
    %2 = tosa.add %1, %1 : (tensor<8x4x9x9xi16>, tensor<8x4x9x9xi16>) -> tensor<8x4x9x9xi16>
    %3 = tosa.reverse %2 {axis = 1 : i32} : (tensor<8x4x9x9xi16>) -> tensor<8x4x9x9xi16>
    %4 = tosa.const_shape  {values = dense<[2, 2, 3, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %5 = tosa.tile %3, %4 : (tensor<8x4x9x9xi16>, !tosa.shape<4>) -> tensor<16x8x27x9xi16>
    %6 = tosa.reverse %5 {axis = 0 : i32} : (tensor<16x8x27x9xi16>) -> tensor<16x8x27x9xi16>
    %7 = tosa.add %6, %5 : (tensor<16x8x27x9xi16>, tensor<16x8x27x9xi16>) -> tensor<16x8x27x9xi16>
    %8 = tosa.clz %7 : (tensor<16x8x27x9xi16>) -> tensor<16x8x27x9xi16>
    %cast = tensor.cast %8 : tensor<16x8x27x9xi16> to tensor<*xi16>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    return
  }
}

