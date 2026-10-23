module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<14> : tensor<10x3x2x2xi8>}> : () -> tensor<10x3x2x2xi8>
    %1 = "tosa.const"() <{values = dense<1> : tensor<10x1x2x2xi8>}> : () -> tensor<10x1x2x2xi8>
    %2 = "tosa.const"() <{values = dense<-6.152000e+01> : tensor<10x7x6x9xf32>}> : () -> tensor<10x7x6x9xf32>
    %3 = tosa.bitwise_and %0, %1 : (tensor<10x3x2x2xi8>, tensor<10x1x2x2xi8>) -> tensor<10x3x2x2xi8>
    %4 = tosa.sub %3, %3 : (tensor<10x3x2x2xi8>, tensor<10x3x2x2xi8>) -> tensor<10x3x2x2xi8>
    %5 = tosa.reciprocal %2 : (tensor<10x7x6x9xf32>) -> tensor<10x7x6x9xf32>
    %6 = tosa.clz %4 : (tensor<10x3x2x2xi8>) -> tensor<10x3x2x2xi8>
    %cast = tensor.cast %5 : tensor<10x7x6x9xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %6 : tensor<10x3x2x2xi8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

