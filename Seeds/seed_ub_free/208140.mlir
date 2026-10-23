module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<178> : tensor<8x9x5xi16>}> : () -> tensor<8x9x5xi16>
    %1 = "tosa.const"() <{values = dense<172> : tensor<8x5x6xi16>}> : () -> tensor<8x5x6xi16>
    %2 = "tosa.const"() <{values = dense<-1.816800e+02> : tensor<4x1xf32>}> : () -> tensor<4x1xf32>
    %3 = "tosa.const"() <{values = dense<8.840000e+00> : tensor<4x1xf32>}> : () -> tensor<4x1xf32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi16>}> : () -> tensor<1xi16>
    %6 = tosa.matmul %0, %1, %4, %5 : (tensor<8x9x5xi16>, tensor<8x5x6xi16>, tensor<1xi16>, tensor<1xi16>) -> tensor<8x9x6xi16>
    %7 = tosa.identity %6 : (tensor<8x9x6xi16>) -> tensor<8x9x6xi16>
    %c0 = "tosa.const"() <{values = dense<0.0> : tensor<4x1xf32>}> : () -> tensor<4x1xf32>
    %a0 = tosa.maximum %2, %c0 : (tensor<4x1xf32>, tensor<4x1xf32>) -> tensor<4x1xf32>
    %8 = tosa.pow %a0, %3 : (tensor<4x1xf32>, tensor<4x1xf32>) -> tensor<4x1xf32>
    %9 = tosa.const_shape  {values = dense<[12, 36]> : tensor<2xindex>} : () -> !tosa.shape<2>
    %10 = tosa.reshape %7, %9 : (tensor<8x9x6xi16>, !tosa.shape<2>) -> tensor<12x36xi16>
    %11 = tosa.reverse %8 {axis = 0 : i32} : (tensor<4x1xf32>) -> tensor<4x1xf32>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<12x36xi16>}> : () -> tensor<12x36xi16>
    %c2 = "tosa.const"() <{values = dense<15> : tensor<12x36xi16>}> : () -> tensor<12x36xi16>
    %a1 = tosa.maximum %10, %c1 : (tensor<12x36xi16>, tensor<12x36xi16>) -> tensor<12x36xi16>
    %a2 = tosa.minimum %a1, %c2 : (tensor<12x36xi16>, tensor<12x36xi16>) -> tensor<12x36xi16>
    %12 = tosa.logical_right_shift %10, %a2 : (tensor<12x36xi16>, tensor<12x36xi16>) -> tensor<12x36xi16>
    %13 = tosa.minimum %11, %8 : (tensor<4x1xf32>, tensor<4x1xf32>) -> tensor<4x1xf32>
    %cast = tensor.cast %12 : tensor<12x36xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %13 : tensor<4x1xf32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}