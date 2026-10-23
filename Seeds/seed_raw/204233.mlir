module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-91.2799987> : tensor<7x5x7xf32>}> : () -> tensor<7x5x7xf32>
    %1 = tosa.reduce_max %0 {axis = 2 : i32} : (tensor<7x5x7xf32>) -> tensor<7x5x1xf32>
    %2 = tosa.reduce_product %1 {axis = 0 : i32} : (tensor<7x5x1xf32>) -> tensor<1x5x1xf32>
    %3 = tosa.log %2 : (tensor<1x5x1xf32>) -> tensor<1x5x1xf32>
    %4 = tosa.log %3 : (tensor<1x5x1xf32>) -> tensor<1x5x1xf32>
    %5 = tosa.abs %4 : (tensor<1x5x1xf32>) -> tensor<1x5x1xf32>
    %cast = tensor.cast %5 : tensor<1x5x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

