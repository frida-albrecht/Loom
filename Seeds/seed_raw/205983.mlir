module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<194> : tensor<10xi32>}> : () -> tensor<10xi32>
    %1 = "tosa.const"() <{values = dense<-73> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<10xi32>, tensor<1xi32>) -> tensor<10xi32>
    %3 = tosa.reduce_product %2 {axis = 0 : i32} : (tensor<10xi32>) -> tensor<1xi32>
    %4 = tosa.add %3, %3 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %5 = tosa.const_shape  {values = dense<1> : tensor<1xindex>} : () -> !tosa.shape<1>
    %6 = tosa.tile %4, %5 : (tensor<1xi32>, !tosa.shape<1>) -> tensor<1xi32>
    %cast = tensor.cast %6 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

