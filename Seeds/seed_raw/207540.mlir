module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.050000e+00> : tensor<7x4x5x7xf32>}> : () -> tensor<7x4x5x7xf32>
    %1 = "tosa.const"() <{values = dense<-96.959999> : tensor<7x1x1x1xf32>}> : () -> tensor<7x1x1x1xf32>
    %2 = tosa.add %0, %1 : (tensor<7x4x5x7xf32>, tensor<7x1x1x1xf32>) -> tensor<7x4x5x7xf32>
    %3 = tosa.tanh %2 : (tensor<7x4x5x7xf32>) -> tensor<7x4x5x7xf32>
    %4 = tosa.log %3 : (tensor<7x4x5x7xf32>) -> tensor<7x4x5x7xf32>
    %5 = tosa.const_shape  {values = dense<980> : tensor<1xindex>} : () -> !tosa.shape<1>
    %6 = tosa.reshape %4, %5 : (tensor<7x4x5x7xf32>, !tosa.shape<1>) -> tensor<980xf32>
    %7 = tosa.const_shape  {values = dense<3> : tensor<1xindex>} : () -> !tosa.shape<1>
    %8 = tosa.tile %6, %7 : (tensor<980xf32>, !tosa.shape<1>) -> tensor<2940xf32>
    %cast = tensor.cast %8 : tensor<2940xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

