module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-50> : tensor<8x4xi32>}> : () -> tensor<8x4xi32>
    %1 = tosa.reduce_sum %0 {axis = 0 : i32} : (tensor<8x4xi32>) -> tensor<1x4xi32>
    %2 = tosa.add %1, %1 : (tensor<1x4xi32>, tensor<1x4xi32>) -> tensor<1x4xi32>
    %3 = tosa.bitwise_or %2, %2 : (tensor<1x4xi32>, tensor<1x4xi32>) -> tensor<1x4xi32>
    %cast = tensor.cast %3 : tensor<1x4xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

