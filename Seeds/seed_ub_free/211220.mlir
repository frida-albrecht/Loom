module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<128> : tensor<4x6x1xi16>}> : () -> tensor<4x6x1xi16>
    %1 = "tosa.const"() <{values = dense<74> : tensor<4x6x1xi16>}> : () -> tensor<4x6x1xi16>
    %2 = "tosa.const"() <{values = dense<-1.042800e+02> : tensor<8x8x5xf32>}> : () -> tensor<8x8x5xf32>
    %3 = "tosa.const"() <{values = dense<98.8099975> : tensor<1x1x1xf32>}> : () -> tensor<1x1x1xf32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<4x6x1xi16>}> : () -> tensor<4x6x1xi16>
    %c1 = "tosa.const"() <{values = dense<15> : tensor<4x6x1xi16>}> : () -> tensor<4x6x1xi16>
    %s0 = tosa.maximum %1, %c0 : (tensor<4x6x1xi16>, tensor<4x6x1xi16>) -> tensor<4x6x1xi16>
    %s1 = tosa.minimum %s0, %c1 : (tensor<4x6x1xi16>, tensor<4x6x1xi16>) -> tensor<4x6x1xi16>
    %4 = tosa.logical_right_shift %0, %s1 : (tensor<4x6x1xi16>, tensor<4x6x1xi16>) -> tensor<4x6x1xi16>
    %c2 = "tosa.const"() <{values = dense<0.0> : tensor<8x8x5xf32>}> : () -> tensor<8x8x5xf32>
    %s2 = tosa.maximum %2, %c2 : (tensor<8x8x5xf32>, tensor<8x8x5xf32>) -> tensor<8x8x5xf32>
    %5 = tosa.pow %s2, %3 : (tensor<8x8x5xf32>, tensor<1x1x1xf32>) -> tensor<8x8x5xf32>
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