module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<27> : tensor<i32>}> : () -> tensor<i32>
    %1 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %2 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %3 = tosa.negate %0, %1, %2 : (tensor<i32>, tensor<1xi32>, tensor<1xi32>) -> tensor<i32>
    %cast = tensor.cast %3 : tensor<i32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

