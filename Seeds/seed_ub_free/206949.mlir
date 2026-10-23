module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1> : tensor<6x4x3x2xi8>}> : () -> tensor<6x4x3x2xi8>
    %1 = "tosa.const"() <{values = dense<-16> : tensor<6x1x3x1xi8>}> : () -> tensor<6x1x3x1xi8>
    %2 = "tosa.const"() <{values = dense<1.627000e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<6x4x3x2xi8>, tensor<6x1x3x1xi8>) -> tensor<6x4x3x2xi8>
    %4 = tosa.tanh %2 : (tensor<2xf32>) -> tensor<2xf32>
    %cast = tensor.cast %3 : tensor<6x4x3x2xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %4 : tensor<2xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

