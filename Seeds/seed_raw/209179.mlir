module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<133> : tensor<2xi32>}> : () -> tensor<2xi32>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<2xi32>) -> tensor<1xi32>
    %2 = tosa.const_shape  {values = dense<0> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %4 = tosa.slice %1, %2, %3 : (tensor<1xi32>, !tosa.shape<1>, !tosa.shape<1>) -> tensor<1xi32>
    %5 = tosa.reduce_sum %4 {axis = 0 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %5 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

