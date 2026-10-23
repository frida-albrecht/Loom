module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-30> : tensor<1x3xi64>}> : () -> tensor<1x3xi64>
    %1 = tosa.const_shape  {values = dense<[3, 1, 1, 1]> : tensor<4xindex>} : () -> !tosa.shape<4>
    %2 = tosa.reshape %0, %1 : (tensor<1x3xi64>, !tosa.shape<4>) -> tensor<3x1x1x1xi64>
    %3 = tosa.abs %2 : (tensor<3x1x1x1xi64>) -> tensor<3x1x1x1xi64>
    %4 = tosa.reduce_product %3 {axis = 2 : i32} : (tensor<3x1x1x1xi64>) -> tensor<3x1x1x1xi64>
    %5 = tosa.equal %4, %2 : (tensor<3x1x1x1xi64>, tensor<3x1x1x1xi64>) -> tensor<3x1x1x1xi1>
    %6 = tosa.add %5, %5 : (tensor<3x1x1x1xi1>, tensor<3x1x1x1xi1>) -> tensor<3x1x1x1xi1>
    %7 = tosa.argmax %6 {axis = 2 : i32} : (tensor<3x1x1x1xi1>) -> tensor<3x1x1xi32>
    %cast = tensor.cast %7 : tensor<3x1x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

