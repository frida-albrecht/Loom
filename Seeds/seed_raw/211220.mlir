module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<128> : tensor<4x6x1xi16>}> : () -> tensor<4x6x1xi16>
    %1 = "tosa.const"() <{values = dense<74> : tensor<4x6x1xi16>}> : () -> tensor<4x6x1xi16>
    %2 = "tosa.const"() <{values = dense<-1.042800e+02> : tensor<8x8x5xf32>}> : () -> tensor<8x8x5xf32>
    %3 = "tosa.const"() <{values = dense<98.8099975> : tensor<1x1x1xf32>}> : () -> tensor<1x1x1xf32>
    %4 = tosa.logical_right_shift %0, %1 : (tensor<4x6x1xi16>, tensor<4x6x1xi16>) -> tensor<4x6x1xi16>
    %5 = tosa.pow %2, %3 : (tensor<8x8x5xf32>, tensor<1x1x1xf32>) -> tensor<8x8x5xf32>
    %6 = tosa.logical_left_shift %4, %4 : (tensor<4x6x1xi16>, tensor<4x6x1xi16>) -> tensor<4x6x1xi16>
    %7 = tosa.argmax %5 {axis = 0 : i32} : (tensor<8x8x5xf32>) -> tensor<8x5xi32>
    %8 = tosa.argmax %7 {axis = 1 : i32} : (tensor<8x5xi32>) -> tensor<8xi32>
    %cast = tensor.cast %6 : tensor<4x6x1xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %8 : tensor<8xi32> to tensor<*xi32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

