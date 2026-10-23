module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<115> : tensor<7x10xi32>}> : () -> tensor<7x10xi32>
    %1 = "tosa.const"() <{values = dense<186> : tensor<7x1xi32>}> : () -> tensor<7x1xi32>
    %2 = tosa.maximum %0, %1 : (tensor<7x10xi32>, tensor<7x1xi32>) -> tensor<7x10xi32>
    %3 = tosa.clamp %2 {max_val = 19 : i32, min_val = 1 : i32} : (tensor<7x10xi32>) -> tensor<7x10xi32>
    %cast = tensor.cast %3 : tensor<7x10xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

