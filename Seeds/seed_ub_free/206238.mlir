module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.846400e+02> : tensor<7x4xf32>}> : () -> tensor<7x4xf32>
    %1 = tosa.reciprocal %0 : (tensor<7x4xf32>) -> tensor<7x4xf32>
    %2 = tosa.reduce_product %1 {axis = 0 : i32} : (tensor<7x4xf32>) -> tensor<1x4xf32>
    %cast = tensor.cast %2 : tensor<1x4xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

