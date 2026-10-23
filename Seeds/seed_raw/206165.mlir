module {
  func.func private @printMemrefI16(tensor<*xi16>) attributes {llvm.emit_c_interface}
  func.func private @printMemrefF32(tensor<*xf32>)
  func.func @main() {
    %0 = "tosa.const"() <{values = dense<-191> : tensor<10x9xi16>}> : () -> tensor<10x9xi16>
    %1 = "tosa.const"() <{values = dense<-1.490900e+02> : tensor<f32>}> : () -> tensor<f32>
    %2 = tosa.identity %0 : (tensor<10x9xi16>) -> tensor<10x9xi16>
    %3 = tosa.clamp %2 {max_val = 99 : i16, min_val = 10 : i16} : (tensor<10x9xi16>) -> tensor<10x9xi16>
    %4 = tosa.floor %1 : (tensor<f32>) -> tensor<f32>
    %5 = tosa.clamp %3 {max_val = 99 : i16, min_val = 10 : i16} : (tensor<10x9xi16>) -> tensor<10x9xi16>
    %6 = tosa.ceil %4 : (tensor<f32>) -> tensor<f32>
    %7 = tosa.bitwise_and %2, %2 : (tensor<10x9xi16>, tensor<10x9xi16>) -> tensor<10x9xi16>
    %8 = tosa.rsqrt %4 : (tensor<f32>) -> tensor<f32>
    %cast = tensor.cast %5 : tensor<10x9xi16> to tensor<*xi16>
    %cast_0 = tensor.cast %6 : tensor<f32> to tensor<*xf32>
    %cast_1 = tensor.cast %7 : tensor<10x9xi16> to tensor<*xi16>
    %cast_2 = tensor.cast %8 : tensor<f32> to tensor<*xf32>
    call @printMemrefI16(%cast) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_0) : (tensor<*xf32>) -> ()
    call @printMemrefI16(%cast_1) : (tensor<*xi16>) -> ()
    call @printMemrefF32(%cast_2) : (tensor<*xf32>) -> ()
    return
  }
}

