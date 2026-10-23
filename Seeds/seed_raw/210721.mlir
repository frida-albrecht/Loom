module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<4.392000e+01> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = "tosa.const"() <{values = dense<12> : tensor<9x2x1x6xi8>}> : () -> tensor<9x2x1x6xi8>
    %2 = "tosa.const"() <{values = dense<-18> : tensor<1x2x1x6xi8>}> : () -> tensor<1x2x1x6xi8>
    %3 = tosa.reciprocal %0 : (tensor<2xf32>) -> tensor<2xf32>
    %4 = tosa.pow %3, %3 : (tensor<2xf32>, tensor<2xf32>) -> tensor<2xf32>
    %5 = tosa.bitwise_and %1, %2 : (tensor<9x2x1x6xi8>, tensor<1x2x1x6xi8>) -> tensor<9x2x1x6xi8>
    %cast = tensor.cast %4 : tensor<2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<9x2x1x6xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

