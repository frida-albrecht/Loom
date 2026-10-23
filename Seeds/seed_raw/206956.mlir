module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.837900e+02> : tensor<4x2x7xf32>}> : () -> tensor<4x2x7xf32>
    %1 = "tosa.const"() <{values = dense<8> : tensor<2x9x1x10xi8>}> : () -> tensor<2x9x1x10xi8>
    %2 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.negate %0, %2, %3 : (tensor<4x2x7xf32>, tensor<1xf32>, tensor<1xf32>) -> tensor<4x2x7xf32>
    %5 = tosa.bitwise_not %1 : (tensor<2x9x1x10xi8>) -> tensor<2x9x1x10xi8>
    %6 = tosa.identity %4 : (tensor<4x2x7xf32>) -> tensor<4x2x7xf32>
    %cast = tensor.cast %5 : tensor<2x9x1x10xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %6 : tensor<4x2x7xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

