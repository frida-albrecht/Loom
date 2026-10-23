module {
  func.func private @printMemrefI8(tensor<*xi8>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.142000e+01> : tensor<6xf32>}> : () -> tensor<6xf32>
    %1 = "tosa.const"() <{values = dense<10> : tensor<5x6xi8>}> : () -> tensor<5x6xi8>
    %2 = "tosa.const"() <{values = dense<-2> : tensor<1x6xi8>}> : () -> tensor<1x6xi8>
    %3 = tosa.tanh %0 : (tensor<6xf32>) -> tensor<6xf32>
    %4 = tosa.log %3 : (tensor<6xf32>) -> tensor<6xf32>
    %5 = tosa.minimum %4, %4 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %6 = tosa.log %5 : (tensor<6xf32>) -> tensor<6xf32>
    %7 = tosa.pow %6, %5 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %8 = tosa.bitwise_xor %1, %2 : (tensor<5x6xi8>, tensor<1x6xi8>) -> tensor<5x6xi8>
    %9 = tosa.sub %7, %4 : (tensor<6xf32>, tensor<6xf32>) -> tensor<6xf32>
    %cast = tensor.cast %8 : tensor<5x6xi8> to tensor<*xi8>
    %cast_0 = tensor.cast %9 : tensor<6xf32> to tensor<*xf32>
    call @printMemrefI8(%cast) : (tensor<*xi8>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

