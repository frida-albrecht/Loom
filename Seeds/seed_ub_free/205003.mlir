module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-27> : tensor<8x4x2x9xi32>}> : () -> tensor<8x4x2x9xi32>
    %1 = "tosa.const"() <{values = dense<5.041000e+01> : tensor<10xf32>}> : () -> tensor<10xf32>
    %2 = tosa.reverse %0 {axis = 0 : i32} : (tensor<8x4x2x9xi32>) -> tensor<8x4x2x9xi32>
    %3 = tosa.exp %1 : (tensor<10xf32>) -> tensor<10xf32>
    %4 = tosa.sigmoid %3 : (tensor<10xf32>) -> tensor<10xf32>
    %5 = tosa.ceil %3 : (tensor<10xf32>) -> tensor<10xf32>
    %cast = tensor.cast %2 : tensor<8x4x2x9xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %4 : tensor<10xf32> to tensor<*xf32>
    %cast_1 = tensor.cast %5 : tensor<10xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefF32(%cast_1) : (tensor<*xf32>) -> ()
    return
  }
}

