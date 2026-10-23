module {
  func.func private @printMemrefI32(tensor<*xi32>)
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<67> : tensor<7x9x5xi32>}> : () -> tensor<7x9x5xi32>
    %1 = "tosa.const"() <{values = dense<-46> : tensor<7x9x5xi32>}> : () -> tensor<7x9x5xi32>
    %2 = "tosa.const"() <{values = dense<-1.734400e+02> : tensor<9x4xf32>}> : () -> tensor<9x4xf32>
    %3 = tosa.bitwise_xor %0, %1 : (tensor<7x9x5xi32>, tensor<7x9x5xi32>) -> tensor<7x9x5xi32>
    %4 = tosa.clamp %3 {max_val = 40 : i32, min_val = -15 : i32} : (tensor<7x9x5xi32>) -> tensor<7x9x5xi32>
    %5 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %6 = "tosa.const"() <{values = dense<0> : tensor<1xi32>}> : () -> tensor<1xi32>
    %7 = tosa.negate %4, %5, %6 : (tensor<7x9x5xi32>, tensor<1xi32>, tensor<1xi32>) -> tensor<7x9x5xi32>
    %8 = tosa.ceil %2 : (tensor<9x4xf32>) -> tensor<9x4xf32>
    %cast = tensor.cast %7 : tensor<7x9x5xi32> to tensor<*xi32>
    %cast_0 = tensor.cast %8 : tensor<9x4xf32> to tensor<*xf32>
    call @printMemrefI32(%cast) : (tensor<*xi32>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    return
  }
}

