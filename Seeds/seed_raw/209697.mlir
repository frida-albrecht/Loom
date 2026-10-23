module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.398100e+02> : tensor<5x2x3xf32>}> : () -> tensor<5x2x3xf32>
    %1 = "tosa.const"() <{values = dense<126> : tensor<3x2xi64>}> : () -> tensor<3x2xi64>
    %2 = tosa.const_shape  {values = dense<0> : tensor<6xindex>} : () -> !tosa.shape<6>
    %3 = "tosa.const"() <{values = dense<0.000000e+00> : tensor<1xf32>}> : () -> tensor<1xf32>
    %4 = tosa.pad %0, %2, %3 : (tensor<5x2x3xf32>, !tosa.shape<6>, tensor<1xf32>) -> tensor<5x2x3xf32>
    %5 = tosa.reduce_product %4 {axis = 1 : i32} : (tensor<5x2x3xf32>) -> tensor<5x1x3xf32>
    %cast = tensor.cast %5 : tensor<5x1x3xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

