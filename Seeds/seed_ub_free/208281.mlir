module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<65> : tensor<5xi32>}> : () -> tensor<5xi32>
    %1 = "tosa.const"() <{values = dense<186> : tensor<5xi32>}> : () -> tensor<5xi32>
    %c0 = "tosa.const"() <{values = dense<0> : tensor<5xi32>}> : () -> tensor<5xi32>
    %c31 = "tosa.const"() <{values = dense<31> : tensor<5xi32>}> : () -> tensor<5xi32>
    %a0 = tosa.maximum %1, %c0 : (tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    %a1 = tosa.minimum %a0, %c31 : (tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    %2 = tosa.logical_right_shift %0, %a1 : (tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    %c1 = "tosa.const"() <{values = dense<1> : tensor<5xi32>}> : () -> tensor<5xi32>
    %a2 = tosa.maximum %2, %c1 : (tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    %3 = tosa.intdiv %2, %a2 : (tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    %cast = tensor.cast %3 : tensor<5xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}