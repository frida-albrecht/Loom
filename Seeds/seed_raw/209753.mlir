module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-8.333000e+01> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.argmax %0 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<i32>
    %cast = tensor.cast %1 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

