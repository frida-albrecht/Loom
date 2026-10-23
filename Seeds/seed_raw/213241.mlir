module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<9.247000e+01> : tensor<6x6x2xf32>}> : () -> tensor<6x6x2xf32>
    %1 = "tosa.const"() <{values = dense<-54> : tensor<5xi32>}> : () -> tensor<5xi32>
    %2 = "tosa.const"() <{values = dense<-13> : tensor<5xi32>}> : () -> tensor<5xi32>
    %3 = tosa.rsqrt %0 : (tensor<6x6x2xf32>) -> tensor<6x6x2xf32>
    %4 = tosa.intdiv %1, %2 : (tensor<5xi32>, tensor<5xi32>) -> tensor<5xi32>
    %5 = tosa.reverse %3 {axis = 2 : i32} : (tensor<6x6x2xf32>) -> tensor<6x6x2xf32>
    %6 = tosa.pow %5, %5 : (tensor<6x6x2xf32>, tensor<6x6x2xf32>) -> tensor<6x6x2xf32>
    %cast = tensor.cast %4 : tensor<5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %6 : tensor<6x6x2xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

