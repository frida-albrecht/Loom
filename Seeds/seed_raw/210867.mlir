module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.804900e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.rsqrt %0 : (tensor<1xf32>) -> tensor<1xf32>
    %2 = tosa.log %1 : (tensor<1xf32>) -> tensor<1xf32>
    %3 = tosa.log %2 : (tensor<1xf32>) -> tensor<1xf32>
    %4 = tosa.argmax %3 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

