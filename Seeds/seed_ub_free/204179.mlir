module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-28> : tensor<10x7x8xi32>}> : () -> tensor<10x7x8xi32>
    %1 = "tosa.const"() <{values = dense<75> : tensor<1x7x1xi32>}> : () -> tensor<1x7x1xi32>
    %2 = tosa.sub %0, %1 : (tensor<10x7x8xi32>, tensor<1x7x1xi32>) -> tensor<10x7x8xi32>
    %3 = tosa.reduce_product %2 {axis = 2 : i32} : (tensor<10x7x8xi32>) -> tensor<10x7x1xi32>
    %c1 = "tosa.const"() <{values = dense<0> : tensor<10x7x1xi32>}> : () -> tensor<10x7x1xi32>
    %c2 = "tosa.const"() <{values = dense<31> : tensor<10x7x1xi32>}> : () -> tensor<10x7x1xi32>
    %a1 = tosa.maximum %3, %c1 : (tensor<10x7x1xi32>, tensor<10x7x1xi32>) -> tensor<10x7x1xi32>
    %a2 = tosa.minimum %a1, %c2 : (tensor<10x7x1xi32>, tensor<10x7x1xi32>) -> tensor<10x7x1xi32>
    %4 = tosa.arithmetic_right_shift %3, %a2 {round = false} : (tensor<10x7x1xi32>, tensor<10x7x1xi32>) -> tensor<10x7x1xi32>
    %5 = tosa.add %4, %3 : (tensor<10x7x1xi32>, tensor<10x7x1xi32>) -> tensor<10x7x1xi32>
    %cast = tensor.cast %5 : tensor<10x7x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}