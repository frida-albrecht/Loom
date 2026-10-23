module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-4.869000e+01> : tensor<7xf32>}> : () -> tensor<7xf32>
    %1 = tosa.floor %0 : (tensor<7xf32>) -> tensor<7xf32>
    %2 = tosa.reduce_min %1 {axis = 0 : i32} : (tensor<7xf32>) -> tensor<1xf32>
    %3 = tosa.tanh %2 : (tensor<1xf32>) -> tensor<1xf32>
    %4 = tosa.reduce_max %3 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %4 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

