module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.383900e+02> : tensor<9x2xf32>}> : () -> tensor<9x2xf32>
    %1 = "tosa.const"() <{values = dense<-1.176700e+02> : tensor<1x2xf32>}> : () -> tensor<1x2xf32>
    %2 = "tosa.const"() <{values = dense<7> : tensor<4x3xi8>}> : () -> tensor<4x3xi8>
    %3 = "tosa.const"() <{values = dense<19> : tensor<1x1xi8>}> : () -> tensor<1x1xi8>
    %4 = tosa.maximum %0, %1 : (tensor<9x2xf32>, tensor<1x2xf32>) -> tensor<9x2xf32>
    %5 = tosa.bitwise_xor %2, %3 : (tensor<4x3xi8>, tensor<1x1xi8>) -> tensor<4x3xi8>
    %cast = tensor.cast %4 : tensor<9x2xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<4x3xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

