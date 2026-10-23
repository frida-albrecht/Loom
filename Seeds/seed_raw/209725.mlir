module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.367100e+02> : tensor<1xf32>}> : () -> tensor<1xf32>
    %1 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %2 = tosa.tile %0, %1 : (tensor<1xf32>, !tosa.shape<1>) -> tensor<1xf32>
    %3 = tosa.reduce_min %2 {axis = 0 : i32} : (tensor<1xf32>) -> tensor<1xf32>
    %cast = tensor.cast %3 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

