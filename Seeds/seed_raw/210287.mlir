module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-187> : tensor<7x8x6xi32>}> : () -> tensor<7x8x6xi32>
    %1 = "tosa.const"() <{values = dense<3> : tensor<1x8x6xi32>}> : () -> tensor<1x8x6xi32>
    %2 = tosa.maximum %0, %1 : (tensor<7x8x6xi32>, tensor<1x8x6xi32>) -> tensor<7x8x6xi32>
    %3 = tosa.logical_left_shift %2, %2 : (tensor<7x8x6xi32>, tensor<7x8x6xi32>) -> tensor<7x8x6xi32>
    %4 = tosa.reduce_product %3 {axis = 2 : i32} : (tensor<7x8x6xi32>) -> tensor<7x8x1xi32>
    %5 = tosa.bitwise_not %4 : (tensor<7x8x1xi32>) -> tensor<7x8x1xi32>
    %cast = tensor.cast %5 : tensor<7x8x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

