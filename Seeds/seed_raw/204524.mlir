module {
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.776500e+02> : tensor<8x10x10x10xf32>}> : () -> tensor<8x10x10x10xf32>
    %1 = tosa.tanh %0 : (tensor<8x10x10x10xf32>) -> tensor<8x10x10x10xf32>
    %2 = tosa.tanh %1 : (tensor<8x10x10x10xf32>) -> tensor<8x10x10x10xf32>
    %3 = tosa.reverse %2 {axis = 1 : i32} : (tensor<8x10x10x10xf32>) -> tensor<8x10x10x10xf32>
    %cast = tensor.cast %3 : tensor<8x10x10x10xf32> to tensor<*xf32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    return
  }
}

