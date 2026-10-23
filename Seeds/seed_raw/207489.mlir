module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<77> : tensor<8xi32>}> : () -> tensor<8xi32>
    %1 = tosa.reduce_min %0 {axis = 0 : i32} : (tensor<8xi32>) -> tensor<1xi32>
    %2 = tosa.sub %1, %1 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %3 = tosa.add %2, %1 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %3 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

