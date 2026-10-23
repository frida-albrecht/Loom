module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.039300e+02> : tensor<2x3xf32>}> : () -> tensor<2x3xf32>
    %1 = "tosa.const"() <{values = dense<-8> : tensor<8xi8>}> : () -> tensor<8xi8>
    %2 = "tosa.const"() <{values = dense<3> : tensor<8xi8>}> : () -> tensor<8xi8>
    %3 = tosa.tanh %0 : (tensor<2x3xf32>) -> tensor<2x3xf32>
    %4 = tosa.exp %3 : (tensor<2x3xf32>) -> tensor<2x3xf32>
    %5 = tosa.sigmoid %4 : (tensor<2x3xf32>) -> tensor<2x3xf32>
    %6 = tosa.arithmetic_right_shift %1, %2 {round = true} : (tensor<8xi8>, tensor<8xi8>) -> tensor<8xi8>
    %7 = tosa.abs %6 : (tensor<8xi8>) -> tensor<8xi8>
    %cast = tensor.cast %5 : tensor<2x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %7 : tensor<8xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

