module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-102> : tensor<5x6xi32>}> : () -> tensor<5x6xi32>
    %1 = "tosa.const"() <{values = dense<-97> : tensor<1x6xi32>}> : () -> tensor<1x6xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<5x6xi32>, tensor<1x6xi32>) -> tensor<5x6xi32>
    %3 = tosa.arithmetic_right_shift %2, %2 {round = false} : (tensor<5x6xi32>, tensor<5x6xi32>) -> tensor<5x6xi32>
    %4 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = tosa.negate %3, %4, %5 : (tensor<5x6xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<5x6xi32>
    %cast = tensor.cast %6 : tensor<5x6xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

