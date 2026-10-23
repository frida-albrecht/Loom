module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<1.492300e+02> : tensor<7x3xf32>}> : () -> tensor<7x3xf32>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<7x3xf32>) -> tensor<1x3xf32>
    %2 = tosa.const_shape  {values = dense<[3, 1, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %3 = tosa.reshape %1, %2 : (tensor<1x3xf32>, !tosa.shape<4>) -> tensor<3x1x1x1xf32>
    %cast = tensor.cast %3 : tensor<3x1x1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

