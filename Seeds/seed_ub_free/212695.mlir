module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.941800e+02> : tensor<4xf32>}> : () -> tensor<4xf32>
    %1 = tosa.ceil %0 : (tensor<4xf32>) -> tensor<4xf32>
    %2 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.tile %1, %2 : (tensor<4xf32>, !tosa.shape<1>) -> tensor<8xf32>
    %4 = tosa.reduce_min %3 {axis = 0 : i32} : (tensor<8xf32>) -> tensor<1xf32>
    %cast = tensor.cast %4 : tensor<1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

