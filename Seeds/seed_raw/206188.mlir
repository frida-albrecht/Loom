module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.388500e+02> : tensor<2x9x8x10xf32>}> : () -> tensor<2x9x8x10xf32>
    %1 = "tosa.const"() <{values = dense<-148> : tensor<10x10x5xi32>}> : () -> tensor<10x10x5xi32>
    %2 = "tosa.const"() <{values = dense<-34> : tensor<10x1x5xi32>}> : () -> tensor<10x1x5xi32>
    %3 = tosa.reciprocal %0 : (tensor<2x9x8x10xf32>) -> tensor<2x9x8x10xf32>
    %4 = tosa.reduce_product %3 {axis = 3 : i32} : (tensor<2x9x8x10xf32>) -> tensor<2x9x8x1xf32>
    %5 = tosa.intdiv %1, %2 : (tensor<10x10x5xi32>, tensor<10x1x5xi32>) -> tensor<10x10x5xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %8 = tosa.negate %5, %6, %7 : (tensor<10x10x5xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<10x10x5xi32>
    %9 = tosa.reduce_product %8 {axis = 1 : i32} : (tensor<10x10x5xi32>) -> tensor<10x1x5xi32>
    %10 = tosa.exp %4 : (tensor<2x9x8x1xf32>) -> tensor<2x9x8x1xf32>
    %cast = tensor.cast %9 : tensor<10x1x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %10 : tensor<2x9x8x1xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

