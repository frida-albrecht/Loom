module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-1.853800e+02> : tensor<6x10x8x7xf32>}> : () -> tensor<6x10x8x7xf32>
    %1 = "tosa.const"() <{values = dense<-1.219100e+02> : tensor<6x1x1x7xf32>}> : () -> tensor<6x1x1x7xf32>
    %2 = "tosa.const"() <{values = dense<11> : tensor<i32>}> : () -> tensor<i32>
    %3 = "tosa.const"() <{values = dense<-4> : tensor<i32>}> : () -> tensor<i32>
    %4 = tosa.add %0, %1 : (tensor<6x10x8x7xf32>, tensor<6x1x1x7xf32>) -> tensor<6x10x8x7xf32>
    %5 = tosa.intdiv %2, %3 : (tensor<i32>, tensor<i32>) -> tensor<i32>
    %cast = tensor.cast %4 : tensor<6x10x8x7xf32> to tensor<*xf32>
    %cast_0 = tensor.cast %5 : tensor<i32> to tensor<*xi32>
    call @printMemrefF32(%cast) : (tensor<*xf32>) -> ()
    call @printMemrefI32(%cast_0) : (tensor<*xi32>) -> ()
    return
  }
}

