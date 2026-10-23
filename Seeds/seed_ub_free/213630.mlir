module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<2> : tensor<3x6x2x2xi32>}> : () -> tensor<3x6x2x2xi32>
    %1 = "tosa.const"() <{values = dense<-158> : tensor<3x6x2x1xi32>}> : () -> tensor<3x6x2x1xi32>
    %2 = tosa.intdiv %0, %1 : (tensor<3x6x2x2xi32>, tensor<3x6x2x1xi32>) -> tensor<3x6x2x2xi32>
    %c0 = "tosa.const"() <{values = dense<1> : tensor<3x6x2x2xi32>}> : () -> tensor<3x6x2x2xi32>
    %s0 = tosa.maximum %2, %c0 : (tensor<3x6x2x2xi32>, tensor<3x6x2x2xi32>) -> tensor<3x6x2x2xi32>
    %3 = tosa.intdiv %2, %s0 : (tensor<3x6x2x2xi32>, tensor<3x6x2x2xi32>) -> tensor<3x6x2x2xi32>
    %4 = tosa.maximum %3, %2 : (tensor<3x6x2x2xi32>, tensor<3x6x2x2xi32>) -> tensor<3x6x2x2xi32>
    %5 = tosa.logical_left_shift %4, %2 : (tensor<3x6x2x2xi32>, tensor<3x6x2x2xi32>) -> tensor<3x6x2x2xi32>
    %6 = tosa.clamp %5 {max_val = 110 : i32, min_val = 30 : i32} : (tensor<3x6x2x2xi32>) -> tensor<3x6x2x2xi32>
    %cast = tensor.cast %6 : tensor<3x6x2x2xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}