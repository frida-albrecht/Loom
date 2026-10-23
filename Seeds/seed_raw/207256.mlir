module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.172000e+01> : tensor<10x7x10x4xf32>}> : () -> tensor<10x7x10x4xf32>
    %1 = tosa.reduce_sum %0 {axis = 3 : i32} : (tensor<10x7x10x4xf32>) -> tensor<10x7x10x1xf32>
    %cast = tensor.cast %1 : tensor<10x7x10x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

