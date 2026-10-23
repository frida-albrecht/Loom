module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<103> : tensor<1xi32>}> : () -> tensor<1xi32>
    %1 = tosa.clamp %0 {max_val = -14 : i32, min_val = -59 : i32} : (tensor<1xi32>) -> tensor<1xi32>
    %2 = tosa.clz %1 : (tensor<1xi32>) -> tensor<1xi32>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %c2 = "tosa.const"() <{values = dense<31> : tensor<1xi32>}> : () -> tensor<1xi32>
    %a1 = tosa.maximum %1, %c1 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %a2 = tosa.minimum %a1, %c2 : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %3 = tosa.arithmetic_right_shift %2, %a2 {round = true} : (tensor<1xi32>, tensor<1xi32>) -> tensor<1xi32>
    %4 = tosa.identity %3 : (tensor<1xi32>) -> tensor<1xi32>
    %5 = tosa.identity %4 : (tensor<1xi32>) -> tensor<1xi32>
    %cast = tensor.cast %5 : tensor<1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}