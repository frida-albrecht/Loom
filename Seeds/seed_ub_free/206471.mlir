module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-143> : tensor<4xi32>}> : () -> tensor<4xi32>
    %1 = tosa.reduce_product %0 {axis = 0 : i32} : (tensor<4xi32>) -> tensor<1xi32>
    %2 = tosa.const_shape  {values = dense<2> : tensor<1xindex>} : () -> !tosa.shape<1>
    %3 = tosa.tile %1, %2 : (tensor<1xi32>, !tosa.shape<1>) -> tensor<2xi32>
    %cast = tensor.cast %3 : tensor<2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

