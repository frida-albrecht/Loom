module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.964300e+02> : tensor<2xf32>}> : () -> tensor<2xf32>
    %1 = tosa.log %0 : (tensor<2xf32>) -> tensor<2xf32>
    %2 = tosa.argmax %1 {axis = 0 : i32} : (tensor<2xf32>) -> tensor<i32>
    %cast = tensor.cast %2 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

