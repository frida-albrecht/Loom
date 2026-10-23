module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<8> : tensor<i8>}> : () -> tensor<i8>
    %1 = "tosa.const"() <{values = dense<-16> : tensor<i8>}> : () -> tensor<i8>
    %2 = "tosa.const"() <{values = dense<-1.957000e+02> : tensor<8xf32>}> : () -> tensor<8xf32>
    %3 = tosa.bitwise_and %0, %1 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %4 = tosa.reciprocal %2 : (tensor<8xf32>) -> tensor<8xf32>
    %5 = tosa.add %3, %3 : (tensor<i8>, tensor<i8>) -> tensor<i8>
    %cast = tensor.cast %4 : tensor<8xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<i8> to tensor<*xi8>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI8(%cast_0) : (tensor<*xi8>) -> ()
    return
  }
}

