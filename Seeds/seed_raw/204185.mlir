module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-3.701000e+01> : tensor<1x8xf32>}> : () -> tensor<1x8xf32>
    %1 = tosa.reduce_product %0 {axis = 1 : i32} : (tensor<1x8xf32>) -> tensor<1x1xf32>
    %cast = tensor.cast %1 : tensor<1x1xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

