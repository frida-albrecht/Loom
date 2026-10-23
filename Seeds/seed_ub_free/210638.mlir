module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.165400e+02> : tensor<3x4xf32>}> : () -> tensor<3x4xf32>
    %1 = tosa.reduce_product %0 {axis = 1 : i32} : (tensor<3x4xf32>) -> tensor<3x1xf32>
    %cast = tensor.cast %1 : tensor<3x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

