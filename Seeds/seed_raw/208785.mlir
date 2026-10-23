module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3> : tensor<7x2x5x2xi8>}> : () -> tensor<7x2x5x2xi8>
    %1 = "tosa.const"() <{values = dense<-1> : tensor<7x2x1x2xi8>}> : () -> tensor<7x2x1x2xi8>
    %2 = "tosa.const"() <{values = dense<1.778600e+02> : tensor<4x3xf32>}> : () -> tensor<4x3xf32>
    %3 = tosa.bitwise_or %0, %1 : (tensor<7x2x5x2xi8>, tensor<7x2x1x2xi8>) -> tensor<7x2x5x2xi8>
    %4 = tosa.exp %2 : (tensor<4x3xf32>) -> tensor<4x3xf32>
    %5 = tosa.bitwise_and %3, %3 : (tensor<7x2x5x2xi8>, tensor<7x2x5x2xi8>) -> tensor<7x2x5x2xi8>
    %cast = tensor.cast %4 : tensor<4x3xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<7x2x5x2xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

