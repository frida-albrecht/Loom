module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.813200e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.tanh %0 : (tensor<1xf32>) -> tensor<1xf32>
    %2 = tosa.reverse %1 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %3 = tosa.ceil %2 : (tensor<1xf32>) -> tensor<1xf32>
    %4 = tosa.const_shape  {values = dense<0> : tensor<1xindex>} : () -> !tosa.shape<1>
    %5 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %6 = tosa.slice %3, %4, %5 : (tensor<1xf32>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<1xf32>
    %7 = tosa.abs %6 : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %7 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

