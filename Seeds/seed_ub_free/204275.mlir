module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-22> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const"() <{values = dense<1.939800e+02> : tensor<1x10xf32>}> : () -> tensor<1x10xf32>
    %2 = tosa.argmax %0 {axis = 0 : i32} : (tensor<10xi32>) -> tensor<i32>
    %3 = tosa.sigmoid %1 : (tensor<1x10xf32>) -> tensor<1x10xf32>
    %4 = tosa.bitwise_xor %2, %2 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %3 : tensor<1x10xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

