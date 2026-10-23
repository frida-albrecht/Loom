module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-120> : tensor<6x3x9xi32>}> : () -> tensor<6x3x9xi32>
    %1 = "tosa.const"() <{values = dense<-12> : tensor<1x3x1xi32>}> : () -> tensor<1x3x1xi32>
    %2 = tosa.minimum %0, %1 : (tensor<6x3x9xi32>, tensor<1x3x1xi32>) -> tensor<6x3x9xi32>
    %3 = tosa.reduce_product %2 {axis = 2 : i32} : (tensor<6x3x9xi32>) -> tensor<6x3x1xi32>
    %4 = tosa.minimum %3, %3 : (tensor<6x3x1xi32>, tensor<6x3x1xi32>) -> tensor<6x3x1xi32>
    %cast = tensor.cast %4 : tensor<6x3x1xi32> to tensor<*xi32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    return
  }
}

